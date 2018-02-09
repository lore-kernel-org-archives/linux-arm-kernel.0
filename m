From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 09 Feb 2018 16:25:29 +0900
Subject: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-Reply-To: <086b44d2-6556-fa7c-1a5b-01c243bf0682@samsung.com>
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
 <20180205142230.9755-1-s.nawrocki@samsung.com>
 <5A7916A2.7010307@samsung.com>
 <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
 <5A7AE1E0.8000509@samsung.com>
 <086b44d2-6556-fa7c-1a5b-01c243bf0682@samsung.com>
Message-ID: <5A7D4CE9.6070900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018? 02? 07? 22:04, Sylwester Nawrocki wrote:
> On 02/07/2018 12:24 PM, Chanwoo Choi wrote:
>> Could you share your equation?
>> because your result is a little bit different of my result.
>> - my equation : ((mdiv + kdiv/65535) x 24MHz) / (pdiv x POWER(2,sdiv))
> 
> It resembles the code from samsung_pll36xx_recalc_rate():
> 
> (24 * 10^6 * (M * 2^16 + K)) / (P * 2^S) / 2^16
> 
> and a more accurate one
> 
> ROUNDDOWN(ROUNDDOWN(24 * 10^6 * (M * 2^16 + K), 0) / ROUNDDOWN(P * 2^S, 0) / 2^16, 0)
> 
> Shouldn't you substitute 65535 with 65536?

65536 is right. It is my mistake using 65535.
Thanks for your share.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
