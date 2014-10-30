From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 11:13:49 +0100
Subject: [PATCH v1 1/2] dtb: xgene: fix: Disable 10GbE and SGMII based
 1GbE by default
In-Reply-To: <1414630580-24640-2-git-send-email-isubramanian@apm.com>
References: <1414630580-24640-1-git-send-email-isubramanian@apm.com>
 <1414630580-24640-2-git-send-email-isubramanian@apm.com>
Message-ID: <1991367.DGHysZpQVP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 October 2014 17:56:19 Iyappan Subramanian wrote:
> @@ -621,7 +621,7 @@
>                         };
>                 };
>  
> -               sgenet0: ethernet at 1f210000 {
> +               sgenet0: sgenet at 1f210000 {
>                         compatible = "apm,xgene-enet";
>                         status = "disabled";
>                         reg = <0x0 0x1f210000 0x0 0x10000>,
> 

This looks like you accidentally reverted a bug fix made earlier.
Network devices should always have the name 'ethernet at ...'.

	Arnd
