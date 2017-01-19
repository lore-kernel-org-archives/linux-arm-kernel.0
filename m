From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 19 Jan 2017 12:34:06 +0100
Subject: [PATCH 2/2] security: Change name of CONFIG_DEBUG_SET_MODULE_RONX
In-Reply-To: <20170119111117.GB11176@leverpostej>
References: <1484789346-21012-1-git-send-email-labbott@redhat.com>
 <1484789346-21012-3-git-send-email-labbott@redhat.com>
 <20170119111117.GB11176@leverpostej>
Message-ID: <20170119113406.GC5110@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 11:11:18AM +0000, Mark Rutland wrote:
> > +config HARDENED_MODULE_MAPPINGS
> > +	bool "Mark module mappings with stricter permissions (RO/W^X)"
> > +	default y
> > +	depends on ARCH_HAS_HARDENED_MODULE_MAPPINGS
> > +	help
> > +	  If this is set, module text and rodata memory will be made read-only,
> > +	  and non-text memory will be made non-executable. This provides
> > +	  protection against certain security vulnerabilities (e.g. modifying
> > +	  code)
> > +
> > +	  Unless your system has known restrictions or performance issues, it
> > +	  is recommended to say Y here.
> > +
> 
> I was hoping that we'd make this mandatory, as we'd already done for
> DEBUG_RODATA.

Same for s390: would be good to make this mandatory.
