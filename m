From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Nov 2016 09:54:55 +0100
Subject: [PATCH v3 09/13] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <20161117230830.31047-10-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
 <20161117230830.31047-10-gregory.clement@free-electrons.com>
Message-ID: <20161118095455.00bfe007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Nov 2016 00:08:26 +0100, Gregory CLEMENT wrote:

> -	soc {
> +	/* The following unit address is composed of the target
> +	 * value (bit [40-47]), attributes value (bits [32-39],
> +	 * and the address value in the window memory: [0-31].
> +	 */
> +	soc at f00100000000 {

Where is this value coming from? Why does the soc node needs to have a
unit address? It doesn't have a 'reg' property if I remember correctly.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
