From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 09 Jul 2013 08:05:13 +0100
Subject: [PATCH v1 0/4] ARM: STi fixes and ethernet support
In-Reply-To: <201307090118.06715.arnd@arndb.de>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
 <201307090118.06715.arnd@arndb.de>
Message-ID: <51DBB629.1050000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd,
On 09/07/13 00:18, Arnd Bergmann wrote:
> On Monday 08 July 2013, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> This patch series fixes 2 configuration issues and adds ethernet support to
>> STiH415, STiH416 based B2000, B2020 boards.
> 
> Hi Srini,
> 
> You really have to send those things separately, as the bug fixes should
> probably go into 3.11, while the rest is new features and needs to be
> reviewed for merging into 3.12.
Yes, I will resend the fixes separately.
> 
> I'm also puzzled by the fact that you add auxdata and callback
> functions for the ether part in the platform code. Those should
> probably all be properties added to the stmmac binding.

stmmac (aka "dwmac" a synopsis IP) driver is integrated in to kernel
sometime in 2.6 series I think :-), and Is used by more than 4 platforms
in 3.10 kernel. The driver is more generic than it sounds.
So adding properties/hooks specific to STiH41x SOCs in driver seemed to
incorrect. Instead doing platform specific bits in the mach via
callbacks was the only choice I had.

Thanks,
srini

> 
> 	Arnd
> 
