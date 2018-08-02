From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Thu, 2 Aug 2018 14:34:44 +0200
Subject: [PATCH 4/4] drm/meson: convert to the new canvas module
In-Reply-To: <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
 <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
Message-ID: <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

2018-08-02 10:39 GMT+02:00 Jerome Brunet <jbrunet@baylibre.com>:
> I looks like the consumer of your 'canvas' devices must know how the canvas
> device is organized internally. Maybe something better can be done ?
>
> Your canvas driver could provide a consumer API, for example:
> meson_canvas_get(): to translate for struct device_node to whatever abstract
> pointer you would need.
> meson_canvas_alloc(), setup(), etc ...
>
> ... This is just adding a bit of indirection but it would help hide the plumbing
> of your canvas driver from the consumers (and repeat this code in each). This
> might be usefull if you ever to make this canvas driver evolve.

Overall the inner workings are hidden as there is an ops struct
instead of public functions.

I agree that the "fetch the node" boilerplate code could be put behind
a helper, but at the same time this code helps remind the developer
that there needs to be a canvas node in the dts, and that it has to be
linked in your own device node.

I would like to keep it that way if that is okay with you.
