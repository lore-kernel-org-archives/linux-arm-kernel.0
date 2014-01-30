From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Jan 2014 13:44:48 +0100
Subject: [RFC] dtc: add ability to make nodes conditional on them being
 referenced
In-Reply-To: <1578575.rVWgTPdq1W@phil>
References: <1578575.rVWgTPdq1W@phil>
Message-ID: <20140130134448.682ab850@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Heiko St?bner wrote:
> From: Heiko Stuebner <heiko.stuebner@bqreaders.com>
> 
> On i.MX, which carries a lot of pin-groups of which most are unused on
> individual boards, they noticed that this plehora of nodes also results
> in the runtime-lookup-performance also degrading [0].
> 
> A i.MX-specific solution defining the pingroups in the board files but
> using macros to reference the pingroup-data was not well received
> 
> This patch is trying to solve this issue in a more general way, by
> adding the ability to mark nodes as needing to be referenced somewhere
> in the tree.
> 
> To mark a node a needing to be referenced it must be prefixed with
> /delete-unreferenced/. This makes dtc check the nodes reference-status
> when creating the flattened tree, dropping it if unreferenced.
> 
> For example, the i.MX6SL pingroup
> 
> 	/delete-uneferenced/ pinctrl_ecspi1_1: ecspi1grp-1 {
                 ^^
s/unef/unref/
not really important here, but bad for copy/pasters


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
