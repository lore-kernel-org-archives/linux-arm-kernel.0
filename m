From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 May 2018 19:18:34 +0100
Subject: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
In-Reply-To: <20180524175024.19874-2-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
Message-ID: <20180524181834.GF4828@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:

> Subsystems or drivers may opt-in to this behavior by calling
> driver_deferred_probe_check_init_done() instead of just returning
> -EPROBE_DEFER. They may use additional information from DT or kernel's
> config to decide whether to continue to defer probe or not.

Should userspace have some involvement in this decision?  It knows if
it's got any intention of loading modules for example.  Kernel config
checks might be good enough, though it's going to be a pain to work out
if the relevant driver is built as a module for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180524/252c8b9e/attachment.sig>
