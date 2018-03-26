From: pierre-yves.mordret@st.com (Pierre Yves MORDRET)
Date: Mon, 26 Mar 2018 10:13:06 +0200
Subject: [PATCH v2 3/6] i2c: i2c-stm32f7: Add initial SMBus protocols
 support
In-Reply-To: <20180324224911.xz3fz2jojcdrovb4@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-4-git-send-email-pierre-yves.mordret@st.com>
 <20180324224911.xz3fz2jojcdrovb4@ninjato>
Message-ID: <2fadcd7f-3bfc-997e-a30e-808f6d854f2c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/24/2018 11:49 PM, Wolfram Sang wrote:
> On Wed, Mar 21, 2018 at 05:48:57PM +0100, Pierre-Yves MORDRET wrote:
>> This patch adds SMBus support for I2C controller embedded in STM32F7 Soc.
> 
>> All SMBus protocols are implemented except SMBus-specific protocols.
> 
> What does that mean?

It miss SMBus Host Notification and SMBBus Alert. They are almost ready but I'm
struggling to put them back to operational state after recent changes related to
SMBust Host Notification. A more "classic" interrupt base solution has been put
in place but I fail to use implement it in my side.
Another patch set is going to be delivered for these 2 commands.

> 
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>     v1:
>>        * Initial
>>     v2:
>>        * fix Kbuild test robot issue (Unneeded semicolon)
>> ---
>>
>> fixup! i2c: i2c-stm32f7: Add initial SMBus protocols support
>> ---
>>  drivers/i2c/busses/i2c-stm32f7.c | 377 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 368 insertions(+), 9 deletions(-)
> 
> That is quite some complexity considering we have I2C_FUNC_SMBUS_EMUL. I
> don't mind, but you really want that?
> 

All SMBBus commands are implemented as such. I never try to emulation commands.
Should we use emulation SMBus commands or real commands... Don't know.
