From: marex@denx.de (Marek Vasut)
Date: Thu, 22 Jan 2015 00:39:01 +0100
Subject: [PATCH V2] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <CAHrpEqQ-eoqM3W1hYcS6EPTmur1FSfm8TeEjYrtZ+PquavL86w@mail.gmail.com>
References: <1419762402-4548-1-git-send-email-stefan.wahren@i2se.com>
 <CAHrpEqQ-eoqM3W1hYcS6EPTmur1FSfm8TeEjYrtZ+PquavL86w@mail.gmail.com>
Message-ID: <201501220039.02073.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 21, 2015 at 05:16:03 PM, Zhi Li wrote:
> On Sun, Dec 28, 2014 at 4:26 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > According to i.MX23 and i.MX28 reference manual the fractional
> > clock control registers must be addressed by byte instructions.
> 
> I don't think mx23 and mx28 have such limitation. I will double check
> with IC team about this.
> RTL is generated from a xml file. All registers implement is unified.
> I don't think only clock control register have such limitation and
> other registers not.

Hi,

Section 10.8.24 in the MX28 datasheet (Fractional Clock Control Register 0) 
states otherwise, but maybe the documentation is simply not matching the
silicon.

Here's a quote:
"
This register controls the 9-phase fractional clock dividers. The fractional 
clock frequencies are a product of the values in these registers. NOTE: This 
register can only be addressed by byte instructions. Addressing word or half-
word are not allowed.
"

I also recall seeing weird behavior when these registers were accessed by word
access in U-Boot, so I believe the datasheet is correct.

Best regards,
Marek Vasut
