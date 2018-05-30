From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 11:37:20 +0100
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
Message-ID: <20180530103720.GH6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 10:23:20PM -0700, Doug Anderson wrote:

> > +                       qcom,drms-mode-max-microamps = <10000 1000000>;

> Things look pretty good to me now.  I'm still hesitant about the whole
> need to list the modes twice (once using the unordered
> "regulator-allowed-modes" and once to match up against the ordered
> "qcom,drms-mode-max-microamps").  I'm also still of the opinion that
> the whole "drms-mode-max-microamps" ought to be a standard property
> (not a qcom specific one) and handled in the regulator core.

I'm confused as to why we are specifying the maximum current the device
can deliver in a given mode in the DT - surely that's a fixed property
of the hardware?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/a7eec198/attachment-0001.sig>
