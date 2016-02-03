From: k@japko.eu (Krzysztof Adamski)
Date: Thu, 4 Feb 2016 00:44:04 +0100
Subject: [PATCH v2 2/5] dts: sun8i-h3: Add APB0 related clocks and resets
In-Reply-To: <20160203222117.GA12071@box2.japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
 <1454448113-18810-3-git-send-email-k@japko.eu>
 <20160203123534.GG4652@lukather>
 <20160203222117.GA12071@box2.japko.eu>
Message-ID: <20160203234403.GB12071@box2.japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 11:21:17PM +0100, Krzysztof Adamski wrote:
>On Wed, Feb 03, 2016 at 01:35:34PM +0100, Maxime Ripard wrote:
>>Hi,
>>
>>I'm not sure what you mean there. The fixed factor clocks only take a
>>single parent, and you provided two.
>
>True, I that's actually some stupid leftover. As mentioned in the 
>commit message I didn't really know how the clock tree looks like here 
>so I wanted to just pretend it's connectet to osc24M. After some 
>experiments I think that 0x01f0140c register does not exist on H3 and 
>I was finally (hopefully) able to understand how this clock is set up 
>in Allwinner's code. So I changed the clock to factors clock with 
>possible osc32k and osc24M parrents. Will send it in v3.

I've changed my mind about using factors clock. The clock I was thinking 
about is only setup for CIR peripheral and I have no information on how 
r_pio is clocked other than the fact it works by default so I assume 
it's clocked from 24M oscillator. New patchset send, let me know what 
you think.
