From: pza@pengutronix.de (Philipp Zabel)
Date: Tue, 23 Dec 2014 13:02:19 +0100
Subject: [PATCH v6 1/3] of: Decrement refcount of previous endpoint in
 of_graph_get_next_endpoint
In-Reply-To: <CANLsYkydZGBQa2KXyVsjp3PaAvfBtOSf+qa0yVdzidJbxcQybw@mail.gmail.com>
References: <1419261091-29888-1-git-send-email-p.zabel@pengutronix.de>
 <1419261091-29888-2-git-send-email-p.zabel@pengutronix.de>
 <CANLsYkydZGBQa2KXyVsjp3PaAvfBtOSf+qa0yVdzidJbxcQybw@mail.gmail.com>
Message-ID: <20141223120219.GB26129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 02:09:46PM -0700, Mathieu Poirier wrote:
> On 22 December 2014 at 08:11, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Decrementing the reference count of the previous endpoint node allows to
> > use the of_graph_get_next_endpoint function in a for_each_... style macro.
> > All current users of this function that pass a non-NULL prev parameter
> > (that is, soc_camera and imx-drm) are changed to not decrement the passed
> > prev argument's refcount themselves.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Acked-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
[...]
> I tested this in my tree - ack.

Thanks!

regards
Philipp
