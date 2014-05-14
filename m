From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 May 2014 11:17:24 +0200
Subject: [PATCH] [RESEND] ARM: remove last use of CONFIG_CPU_ARM710
In-Reply-To: <1400055865.31197.4.camel@x220>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <1400055865.31197.4.camel@x220>
Message-ID: <8309592.drxAj71PnZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 May 2014 10:24:25 Paul Bolle wrote:
> Support for ARM710 CPUs was removed in v3.5. Now remove the last code
> depending on its Kconfig macro.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> First submitted in March 2103. Still untested. Please note that
> cpu_arm7_data_abort was also removed in v3.5.
> 

'git grep -i arm710' tells me that there is also some arm710
specific code in  arch/arm/mm/proc-arm720.S that we may want to
remove along with this.

The DT binding should probably remain untouched though, I think it's
correct to document the string.

	Arnd
