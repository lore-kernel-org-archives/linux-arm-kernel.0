From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Thu, 2 Jun 2016 23:40:04 +0100
Subject: [Intel-gfx] [PATCH 01/20] drm/atomic: Fix remaining places where
 !funcs->best_encoder is valid
In-Reply-To: <CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464877907-27723-2-git-send-email-boris.brezillon@free-electrons.com>
 <8671722.LHaiaBNqfE@avalon>
 <CAKMK7uHyqNbA8Scw2fE0geAyNt0a0XVtzf81nwWjEhbZ-gAvKw@mail.gmail.com>
Message-ID: <20160602224004.GA1819@nuc-i3427.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 11:57:02PM +0200, Daniel Vetter wrote:
> drm_encoder_find is an idr lookup. That should be plenty fast,
> especially for modeset code. Usually what's too expensive even for
> modeset code is linear list walks. But Chris just submitted patches to
> convert most of them into simple lookups.

For the idr_find, I'm tempted to replace the mutex with a rwlock. It
helps pathological cases, but in reality there are more crucial
locks around the hw that limit concurrency. ;-)
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
