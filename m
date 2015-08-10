From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Aug 2015 11:25:15 +0100
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
 <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
 <55C4E597.1010701@ti.com>
 <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
Message-ID: <20150810102515.GA1965@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 09, 2015 at 03:03:14PM +0200, Tomeu Vizoso wrote:

> There was some recent thread about how the disabling of unused clocks
> and regulators isn't really safe because after late_initcall_sync more
> drivers can be registered from modules. Furthermore, there's async
> device probes.

What recent thread and why would that be unsafe?  Any driver using a
clock or regulator ought to be making sure that the clock or regulator
is enabled before it tries to use it.  The worst that should happen is
that something gets the power bounced during boot which isn't the end of
the world.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/5a6b2746/attachment.sig>
