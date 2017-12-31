From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Sun, 31 Dec 2017 13:40:07 +0000
Subject: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
In-Reply-To: <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
Message-ID: <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/12/17 16:36, Mikko Perttunen wrote:
> FWIW, we had this problem some years ago with the Tegra CPU clock - then 
> it was determined that a simpler solution was to have the determine_rate 
> callback support unsigned long rates - so clock drivers that need to 
> return rates higher than 2^31 can instead implement the determine_rate 
> callback. That is what's currently implemented.
> 
> Mikko

Granted we could work around it but, having both zero and less than zero 
indicate error means you can't support larger than LONG_MAX which is I 
think worth fixing.

---
bod
