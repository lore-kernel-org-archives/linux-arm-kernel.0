From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Sun, 3 Apr 2011 20:28:13 -0300
Subject: [PATCH 1/3] ARM: mx5/mx53_loco: Add write-protect and card-detect
	for SD3
In-Reply-To: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
References: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <4D99028D.4000808@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 4/1/2011 4:29 PM, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)

Please don?t apply this patch yet. 

After further testing I realize that I get the following errors after applying this patch:

mmc1: new high speed SDHC card at address aaaa                
mmcblk1: mmc1:aaaa SD08G 7.40 GiB                                               
 mmcblk1: p1 p2                                                                 
mmc1: Timeout waiting for hardware interrupt.                                   
mmcblk1: retrying using single block read                                       
mmcblk1: error -84 transferring data, sector 32769, nr 32, card status 0x900    
end_request: I/O error, dev mmcblk1, sector 32769                               
Buffer I/O error on device mmcblk1p2, logical block 0                           
mmcblk1: error -84 transferring data, sector 32770, nr 31, card status 0x900    
end_request: I/O error, dev mmcblk1, sector 32770                               
Buffer I/O error on device mmcblk1p2, logical block 1                           
mmcblk1: error -84 transferring data, sector 32771, nr 30, card status 0x900    
end_request: I/O error, dev mmcblk1, sector 32771                               

Will start debugging it.

Regards,

Fabio Estevam
