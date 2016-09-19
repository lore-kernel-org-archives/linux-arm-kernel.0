From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Tue, 20 Sep 2016 00:18:48 +0100
Subject: [PATCH v9 17/19] drm/virtio: kconfig: Fix recursive dependency
 issue.
In-Reply-To: <1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-18-git-send-email-peter.griffin@linaro.org>
Message-ID: <CACvgo52_g7anGBd9HTUyYsbp5QmQEk9LR3nNHgSTgjQ29G3ViA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 September 2016 at 14:16, Peter Griffin <peter.griffin@linaro.org> wrote:
> ST_SLIM_REMOTEPROC must select REMOTEPROC, which exposes the following
> recursive dependency.
>
>From a humble skim through remoteproc, drm and a few other subsystems
I think the above is wrong. All the drivers (outside of remoteproc),
that I've seen, depend on the core component, they don't select it.

Furthermore most places explicitly hide the drivers from the menu if
the core component isn't enabled.

Is there something that requires such a different/unusual behaviour in
remoteproc ?

Regards,
Emil
