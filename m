From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 3 Mar 2013 13:34:08 +0100
Subject: [PATCH v6 01/16] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <51333B07.7050106@gmail.com>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <51333149.1060105@gmail.com> <51333B07.7050106@gmail.com>
Message-ID: <201303031334.08931.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 3. M?rz 2013, 12:59:03 schrieb Sylwester Nawrocki:
> On 03/03/2013 12:17 PM, Sylwester Nawrocki wrote:
> > On 03/03/2013 02:08 AM, Heiko St?bner wrote:
> >> But is there an easy way to define more than one alias? On the s3c2416
> >> for
> >> example the hsmmc hclk is the "hsmmc" io-clock, as well as the source
> >> for the
> >> "mmc_busclk.0". Same for the "uart" pclk, that is also a baud clock
> >> source.
> 
> [...]
> 
> > But those multiple aliases are important only for machines with device
> 
>                                                               ^^^^^
> Sorry, this should have read "without". Also please note that due to
> representing original struct clk_clksrc objects (mux + div + gate clock)
> with separate primitive clocks device drivers may not work as before
> where clk_{set/get}_parent() was called. I.e. a separate consumer clock
> id needs to be used to control a clock mux. Hmm, however this issue
> doesn't affect anything on s3c24xx, since such composite clocks have
> been introduced only starting from s3c64xx.
> 
> I guess to create multiple aliases now a new helper function could be
> created that takes as an argument a clock index (as in enum exynos4_clks)
> and adds a clkdev lookup entry to a matched clk object. Probably it
> wouldn't be difficult to rework the driver to be registering all clkdev
> entries like this.
> 
> Do you have your source tree in any public git available ? ;) Perhaps
> I could find a time to adjust and try it with s3c2440 based board.

It's all quite messy still :-) ... I just managed to fix my last boot issues 
with adding the baud clock aliases. 

As I'm currently working on a linux-next variant with a lot of pending patches 
merged in, there is no public git tree of it. But I've attached an archive of 
the changes I did. As always I'm doing s3c2416 and s3c2443 as they are quite 
similar, but as always there is a big difference to SoCs earlier than s3c2443.


Heiko
-------------- next part --------------
A non-text attachment was scrubbed...
Name: s3c2416-clk.tar.gz
Type: application/x-compressed-tar
Size: 16112 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130303/e235bf90/attachment.bin>
