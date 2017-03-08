From: monnier@iro.umontreal.ca (Stefan Monnier)
Date: Tue, 07 Mar 2017 23:16:59 -0500
Subject: [PATCH 10/15] drm/sun4i: tcon: Switch mux on only for composite
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67iTOV-=u5rReu6_wi6NFoCoJkbJKshTpmFYUmJ=ggKUw@mail.gmail.com>
Message-ID: <jwvmvcwflnm.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +       if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
>> +               val = 1;
>> +       else
>> +               val = 0;

Isn't this better written as

           val = (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC);


-- Stefan
