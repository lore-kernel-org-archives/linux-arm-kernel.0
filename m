From: mikpe@it.uu.se (Mikael Pettersson)
Date: Mon, 31 Aug 2009 11:30:30 +0200
Subject: [RFC] ARM: increase L1_CACHE_SHIFT
In-Reply-To: <1251460695-26481-1-git-send-email-aaro.koskinen@nokia.com>
References: <1251460695-26481-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <19099.38966.482309.340880@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen writes:
 > Hello,
 > 
 > ARM Cortex-A8 has 64 byte cache line, so the current code is
 > wrong. This is little worrying if you e.g. read the comments from
 > eb5f4ca9536ba297c98721ecbbdf41ec5b987bd5.
 > 
 > What would be the proper way to handle this? Should we set it to 64
 > bytes for everyone, or set it according to some #define or Kconfig option?

It should be an internal (not user-selectable) CONFIG symbol
synthesized from the CPU type selection option. See e.g. the
x86 Kconfig for an example on how this can be done.

It's probably cleaner to have the CPU selection options "select"
appropriate L1_CACHE_SHIFT_$N options than to force the L1_CACHE_SHIFT
option to enumerate all possible CPU types for a given shift value.

/Mikael
