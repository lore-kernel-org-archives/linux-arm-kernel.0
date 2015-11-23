From: schwab@suse.de (Andreas Schwab)
Date: Mon, 23 Nov 2015 17:49:27 +0100
Subject: [RFC2 PATCH v6 00/19] ILP32 for ARM64
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 (Yury Norov's message of "Wed, 18 Nov 2015 00:16:40 +0300")
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <mvm37vwoe3s.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yury Norov <ynorov@caviumnetworks.com> writes:

> v6:
>  - time_t, __kenel_off_t and other types turned to be 32-bit
>    for compatibility reasons (after v5 discussion);
>  - related changes applied to ILP32 syscall table and handlers;
>  - ILP32 VDSO code excluded. It's not mandatory, and caused questions
>    during review process. We definitely make sure we will follow up
>    with a VDSO later on because it is needed for performance reasons;
>  - fixed build issues with different combinations of AARCH32 / ILP32
>    enabling in config;
>  - ILP32 TLS bug fixed;
>  - entry32-common.S introduced to hold wrappers needed for both ILP32
>    and AARCH32_EL0;
>  - documentation updated according to latest changes;
>  - rebased to the current head;
>  - coding style re-checked;
>  - ILP32 syscall table turned around.

For some reason signal frame setup has been broken with this
incarnation.  I'm seeing x30 == 0 on entry to the signal handler.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
