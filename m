From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Oct 2012 20:13:13 +0200
Subject: [PATCH v2 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <1349969282-12676-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1349969282-12676-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1349969282-12676-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121011181312.GB3850@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, Oct 11, 2012 at 05:27:59PM +0200, Thomas Petazzoni wrote:
> +module_param(mvneta_rxq_number, int, S_IRUGO);
> +module_param(mvneta_txq_number, int, S_IRUGO);
> +
> +module_param(mvneta_rxq_def, int, S_IRUGO);
> +module_param(mvneta_txq_def, int, S_IRUGO);

Since these are module params they need the driver name prefix when referenced 
in the kernel command line, so there should be no need for another "mvneta" 
prefix.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
