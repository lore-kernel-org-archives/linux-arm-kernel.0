From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 14 May 2014 11:25:50 +0200
Subject: [PATCH] [RESEND] ARM: remove last use of CONFIG_CPU_ARM710
In-Reply-To: <8309592.drxAj71PnZ@wuerfel>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <1400055865.31197.4.camel@x220> <8309592.drxAj71PnZ@wuerfel>
Message-ID: <1400059550.31197.12.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-05-14 at 11:17 +0200, Arnd Bergmann wrote:
> 'git grep -i arm710' tells me that there is also some arm710
> specific code in  arch/arm/mm/proc-arm720.S that we may want to
> remove along with this.
> 
> The DT binding should probably remain untouched though, I think it's
> correct to document the string.

That seems to be cpu_arm710_name, __arm710_setup, and everything called
by __arm710_setup. Cleaning that up (as a separate patch) appears to be
trivial. If I do that it would be (sort of educated) guesswork. But I
don't mind doing it. What do you prefer?


Paul Bolle
