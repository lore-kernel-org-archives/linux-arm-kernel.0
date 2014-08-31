From: leigh@solinno.co.uk (Leigh Brown)
Date: Sun, 31 Aug 2014 23:30:10 +0100
Subject: [PATCH 1/4] clk: mvebu: Fix clk frequency value if SSCG is enabled
In-Reply-To: <d9e3be49b00eb7dd8827f05a955b4497@doppler.thel33t.co.uk>
References: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>
 <1409312620-20631-2-git-send-email-gregory.clement@free-electrons.com>
 <d9e3be49b00eb7dd8827f05a955b4497@doppler.thel33t.co.uk>
Message-ID: <ba70e97da698fe6053adbb6218c905a3@doppler.thel33t.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-31 23:25, Leigh Brown wrote:
[...]
> /* NB: 0.96% = 0.0048 or 3/625 */
> freq_swing_half = (((u64)high_bound - (u64)low_bound)
> 		* (u64)system_clk * 3);
> do_div(freq_swing_half, (625 * high_bound));

Sigh.  The comment should be:

/* NB: half of 0.96% is 0.0048 or 3/625 */

The code should be right :-)

Regards,

Leigh.
