From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 16 Mar 2016 11:03:38 -0300
Subject: [PATCH 5/5] [media] media-device: make media_device_cleanup()
 static
In-Reply-To: <864cdbedcdde600b09d77bfecb1b828e16e41ac0.1458129823.git.mchehab@osg.samsung.com>
References: <dba4d41bdfa6bb8dc51cb0f692102919b2b7c8b4.1458129823.git.mchehab@osg.samsung.com>
 <864cdbedcdde600b09d77bfecb1b828e16e41ac0.1458129823.git.mchehab@osg.samsung.com>
Message-ID: <CABxcv=mvtXBs9qu6+HDbiB4pmMAM9cf=3mPTtLp0XWftRrGM1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mauro,

The patch looks mostly good to me, I just have a question below:

On Wed, Mar 16, 2016 at 9:04 AM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:

[snip]

>
> -void media_device_cleanup(struct media_device *mdev)
> +static void media_device_cleanup(struct media_device *mdev)
>  {
>         ida_destroy(&mdev->entity_internal_idx);
>         mdev->entity_internal_idx_max = 0;
>         media_entity_graph_walk_cleanup(&mdev->pm_count_walk);
> -       mutex_destroy(&mdev->graph_mutex);

Any reason why this is removed? mutex_init() is still called in
media_device_init() so I believe the destroy should be kept here.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
