From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 11:38:28 +0100
Subject: [PATCH v9 2/4] Documentation: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <CAPw-ZT=QXwOVvpgJSL5qU8J2eEuAt3nnXJDfDwPXTTo7z4Fe-A@mail.gmail.com>
References: <1389769910-15505-1-git-send-email-lho@apm.com>
 <CAPw-ZTmn-aNJcLd1mZPRtog_ncq=GC94ULCJb-400oYqERYK5g@mail.gmail.com>
 <CAPw-ZT=QXwOVvpgJSL5qU8J2eEuAt3nnXJDfDwPXTTo7z4Fe-A@mail.gmail.com>
Message-ID: <3162202.3lfb3jYxiv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 15:59:27 Loc Ho wrote:
> 
> May be I misread what Mark mentioned. The binding documentation should
> not specify the requirement of 0. And the binding of the dts should be
> as is:
> 
> phy1 {
>    #phy-cells = <1>;
> };
> 
> sata1 {
>    :::
>    phys = <&phy1 0>;     where 0 indicates the mode of operation?
> };
> 
> 

Yes, that is right. You can keep the zero in the example, but the
binding text must not require a specific phy to be used.

	Arnd
