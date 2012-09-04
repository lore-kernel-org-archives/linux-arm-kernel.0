From: robherring2@gmail.com (Rob Herring)
Date: Tue, 04 Sep 2012 17:02:15 -0500
Subject: [PATCH 1/3] ARM: move debug macros to common location
In-Reply-To: <20120901085340.GA20497@lunn.ch>
References: <20120901085340.GA20497@lunn.ch>
Message-ID: <50467A67.3010300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2012 03:53 AM, Andrew Lunn wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Based on suggestion by Russell King, create a common location for debug
>> macros and select the included debug macro file using config option.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/Kconfig.debug          |    5 +++
>>  arch/arm/include/debug/icedcc.S |   90 +++++++++++++++++++++++++++++++++++++++
>>  arch/arm/kernel/debug.S         |   87 ++-----------------------------------
>>  arch/arm/kernel/head.S          |    4 +-
>>  4 files changed, 100 insertions(+), 86 deletions(-)
>>  create mode 100644 arch/arm/include/debug/icedcc.S
> 
> Hi Rob
> 
> What about arch/arm/include/asm/hardware/debug-8250.S and
> arch/arm/include/asm/hardware/debug-pl01x.S?
> 
> Might be nice to have these two also in arch/arm/include/debug/, or
> follow the naming convention set by these two and have
> arch/arm/include/asm/hardware/debug-icedcc.S?

I agree we should move those, but would rather do it after moving all
the debug-macro.S files into include/debug. As I mentioned in the
multi-platform thread, I think there are further improvements we can do
and eliminate many of the debug-macro.S files.

Rob
