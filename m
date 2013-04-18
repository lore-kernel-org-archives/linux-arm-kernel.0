From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Apr 2013 12:13:06 +0200
Subject: [PATCH v3] ARM: at91: add Acme Systems Aria G25 board
In-Reply-To: <516FB671.2030706@atmel.com>
References: <20130402184947.GA8015@quad.lixom.net>
 <1365090153-1807-1-git-send-email-nicolas.ferre@atmel.com>
 <515DB248.6070105@interlog.com> <516FB671.2030706@atmel.com>
Message-ID: <516FC732.9080109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 11:01 AM, Nicolas Ferre :
> On 04/04/2013 07:03 PM, Douglas Gilbert :

[..]

>> The lack of use of uart1 is for my own, private reasons.
>> I think it would be more generally useful to show uart1's
>> definition and disable it as shown in the attached patch
>> fragment.
> 
> Well, if uart1 is available on Aria board, I should enable it! If you do
> not want it on your own design, you must modify the .dts yourself. So I
> plan to have an "okay" status on it (and move the definition itself to
> the generic .dtsi).

Update: I have just checked the ACME website and both UART0 and UART1
pins are expected to be used as GPIOs. So maybe we should mark them as
"disabled":

+                       /*
+                        * UART1 pins are marked as GPIO on Aria
+                        * documentation: change to "okay" if you need
+                        * an additional serial port
+                        */
+                       uart0: serial at f8040000 {
+                               status = "disabled";
+                       };
+
+                       uart1: serial at f8044000 {
+                               status = "disabled";
+                       };

(uart0 definition moved to at91sam9x5.dtsi)
What do you think?

[..]

Bye,
-- 
Nicolas Ferre
