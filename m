From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 01 Aug 2013 21:30:08 +0400
Subject: [PATCH] USB: ohci-at91: add usb_clk for transition to common
 clk framework
In-Reply-To: <Pine.LNX.4.44L0.1308011153180.1534-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1308011153180.1534-100000@iolanthe.rowland.org>
Message-ID: <51FA9B20.3080304@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/01/2013 07:56 PM, Alan Stern wrote:

>>> What happens if uclk isn't found but it is needed?

>> It will not fail but I guess the usb host won't work as the clock won't
>> be correctly
>> configured.

>> I agree with you: this is not a good solution.

>> Another option is to keep the previous version of this patch and put
>> uclk handling
>> in "#ifdef CONFIG_COMMON_CLK #endif" sections.

>> Would this be acceptable ?

> Yes.  However, a more elegant approach is to protect the relevant
> statements with: if (defined(CONFIG_COMMON_CLK)).  This preprocessor

    You probably meant IS_ENABLED() or IS_BUIILTIN()? Or is there something I 
don't know about gcc preprocessor?

> evaluates this to a 0 or 1, so the compiler will not generate output
> for the protected source code if the symbol isn't defined.

> Alan Stern

WBR, Sergei
