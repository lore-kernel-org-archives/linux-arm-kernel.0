From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 May 2018 14:03:30 +0200
Subject: [PATCH RESEND net-next v2 1/8] dt-bindings: net: dwmac-sun8i:
 Clean up clock delay chain descriptions
In-Reply-To: <20180514072113.yts3shbojvbxj4tq@flea>
References: <20180513191425.9801-1-wens@csie.org>
 <20180513191425.9801-2-wens@csie.org>
 <20180513194919.GE12738@lunn.ch>
 <CAGb2v66nqWnioS1pwfWFtMZFZSWvf4SwXr_ExnnGvYsK9RU_LA@mail.gmail.com>
 <20180513200529.GF12738@lunn.ch>
 <CAGb2v64ACc1tQRhy4LhnvCC7VJ3nVM-wMbgUgzviGMWKPFsSuQ@mail.gmail.com>
 <20180513202938.GH12738@lunn.ch>
 <CAGb2v66F_Ho2OZdrF3p6xe9mQ=zJZ_KjE9MnW1VmWs9jw65eEg@mail.gmail.com>
 <20180514072113.yts3shbojvbxj4tq@flea>
Message-ID: <20180514120330.GA25241@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Currently no other board requires this, but this is already part of the
> > binding. The new stuff limits the range for a specific SoC, simply because
> > that is the range supported by the control register. Not implementing, i.e.
> > supporting the whole range from the property, which might get truncated,
> > doesn't make much sense to me.
> 
> With that driver we don't, but the previous design had the same
> feature and it was used on more boards. It was simply initialized
> statically in U-Boot, and not in Linux through the DT like it is done
> here.

If there are boards which do need it, then i'm fine with it. I would
also prefer that Linux does set it, and don't rely on U-boot.

   Andrew
