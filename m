From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 15 May 2018 15:02:14 -0700
Subject: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
In-Reply-To: <5a449d93-eef0-4243-9889-bd13786edde1@linux.intel.com>
References: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
 <20180501150236.GA15330@rob-hp-laptop>
 <5a449d93-eef0-4243-9889-bd13786edde1@linux.intel.com>
Message-ID: <152642173468.237094.11026813184254392663@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jae Hyun Yoo (2018-05-01 09:27:32)
> On 5/1/2018 8:02 AM, Rob Herring wrote:
> > On Thu, Apr 26, 2018 at 10:22:32AM -0700, Jae Hyun Yoo wrote:
> >> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
> >> index d3558d897a4d..8d69b9134bef 100644
> >> --- a/include/dt-bindings/clock/aspeed-clock.h
> >> +++ b/include/dt-bindings/clock/aspeed-clock.h
> >> @@ -45,7 +45,7 @@
> >>   #define ASPEED_RESET_JTAG_MASTER   3
> >>   #define ASPEED_RESET_MIC           4
> >>   #define ASPEED_RESET_PWM           5
> >> -#define ASPEED_RESET_PCIVGA         6
> >> +#define ASPEED_RESET_PECI           6
> > 
> > You can't really be changing these as they represent an ABI.
> > 
> > Is there no PCIVGA reset?
> > 
> 
> This is a bug fixing. Previously, PCI/VGA used PECI reset bit so this
> patch corrects the reset bit for PCI/VGA from bit '10' to bit '8', and
> it adds PECI reset bit '10' here as it can't be combined with a clock
> gate bit.
> 

Presumably nobody is using the #define because it's wrong, so this is OK
for me. I'll apply to clk-next and yank it if Rob objects.
