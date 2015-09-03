From: treding@nvidia.com (Thierry Reding)
Date: Thu, 3 Sep 2015 10:47:37 +0200
Subject: [PATCH v4 14/16] drm: bridge: analogix/dp: try force hpd after
 plug in lookup failed
In-Reply-To: <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441088079-25809-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqJDALnjVaVoEqGGsSLeE31m3MKOfbSoZ3M+g+zPZR2MFg@mail.gmail.com>
Message-ID: <20150903084735.GB3784@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 03:17:57PM -0500, Rob Herring wrote:
[...]
> Are there any eDP panels which don't have EDID and need panel details in DT?

Most panels need information other than EDID. They typically have some
requirements regarding the power up sequence that aren't to be found
anywhere in EDID or detectable by some other mechanism. A decision was
therefore made a long time ago to require panels to be listed in DT with
a specific compatible string. That way all of these details can be
stashed away in drivers that know how to deal with these kinds of
details.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/f4039697/attachment.sig>
