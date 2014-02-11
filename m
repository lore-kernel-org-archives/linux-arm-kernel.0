From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 17:32:03 +0100
Subject: [PATCH v2] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <1392054179-28830-1-git-send-email-gregory.clement@free-electrons.com>
References: <1392054179-28830-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140211173203.4e6c7b22@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 10 Feb 2014 18:42:59 +0100, Gregory CLEMENT wrote:
> Until now the clock providers were initialized in the order found in
> the device tree. This led to have the dependencies between the clocks
> not respected: children clocks could be initialized before their
> parent clocks.
> 
> Instead of forcing each platform to manage its own initialization order,
> this patch adds this work inside the framework itself.
> 
> Using the data of the device tree the of_clk_init function now delayed
> the initialization of a clock provider if its parent provider was not
> ready yet.
> 
> The strict dependency check (all parents of a given clk must be
> initialized) was added by Boris BREZILLON
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Since the v1, I have merged the  strict dependency check from Boris.
> And of course tested on my Armada 370 and Armada XP based board
> 
>  drivers/clk/clk.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 106 insertions(+), 3 deletions(-)

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On the newly proposed Armada 375 platform.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
