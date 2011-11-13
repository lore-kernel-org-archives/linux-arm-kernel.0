From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 13 Nov 2011 16:47:36 +0200
Subject: [QUESTION] omap iommu: a generic IOMMU?
In-Reply-To: <CACVXFVOvFAbGsXBsRTYC=JWRrh9_tZ_jwgPp+3evxCvXy9inVA@mail.gmail.com>
References: <CACVXFVPLgXfcpE9x2KKbU=r9_+ZeEbfo1TGndvm6yi34V15tPA@mail.gmail.com>
 <CAK=Wgba+m6D7hhr0CrfzrC7mAB=6NFhbik4qte7OPGGo0v6oYQ@mail.gmail.com>
 <CACVXFVOvFAbGsXBsRTYC=JWRrh9_tZ_jwgPp+3evxCvXy9inVA@mail.gmail.com>
Message-ID: <CAK=Wgba52OgASTrZyP+U6=5q6ZLzPRXxjjaAhHoBO5MnqewpxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2011 at 4:07 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> Could you give a use case about the usage of controlling the iommu from
> the A9?

E.g. before we boot the M3, we first configure its MMU (otherwise
every memory access it will do will fail).

> I understand that the M3 and DSP can do this too, :-)

AFAIK the M3 can't configure its own MMU, but even if it could, you
have a catch 22 here as it can't even access its very first
instruction without first having its MMU configured correctly to point
at it ;)
