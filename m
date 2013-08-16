From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 17 Aug 2013 08:14:33 +1000
Subject: [RFC PATCH v2 4/4] of: move of_get_cpu_node implementation to
 DT core library
In-Reply-To: <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1376691273.25016.5.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
> +#ifdef CONFIG_PPC
> +               /* Check for historical "ibm,ppc-interrupt-server#s" property
> +                * for thread ids on PowerPC. If it doesn't exist fallback to
> +                * standard "reg" property.
> +                */
> +               if (__of_find_n_match_cpu_property(cpun,
> +                               "ibm,ppc-interrupt-server#s", cpu, thread))
> +                       return cpun;
> +#endif

It's not "historical". It's still very much in use and well defined in PAPR :-)

Cheers,
Ben.
