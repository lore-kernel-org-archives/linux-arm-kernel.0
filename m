From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 14 Aug 2015 13:33:48 +0300
Subject: [PATCH RFC v3 07/16] media: get rid of unused "extra_links"
 param on media_entity_init()
In-Reply-To: <7b9f2654888f0fd54c290c50f50248a367768da7.1439410053.git.mchehab@osg.samsung.com>
References: <cover.1439410053.git.mchehab@osg.samsung.com>
 <7b9f2654888f0fd54c290c50f50248a367768da7.1439410053.git.mchehab@osg.samsung.com>
Message-ID: <20150814103348.GC19840@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Wed, Aug 12, 2015 at 05:14:51PM -0300, Mauro Carvalho Chehab wrote:
> Currently, media_entity_init() creates an array with the links,
> allocated at init time. It provides a parameter (extra_links)
> that would allocate more links than the current needs, but this
> is not used by any driver.
> 
> As we want to be able to do dynamic link allocation/removal,
> we'll need to change the implementation of the links. So,
> before doing that, let's first remove that extra unused
> parameter, in order to cleanup the interface first.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> 
...


> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index 738e1d5d25dc..be6885e7c8ed 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -177,7 +177,7 @@ void graph_obj_init(struct media_device *mdev,
>  void graph_obj_remove(struct media_graph_obj *gobj);
>  
>  int media_entity_init(struct media_entity *entity, u16 num_pads,
> -		struct media_pad *pads, u16 extra_links);
> +		struct media_pad *pads);
>  void media_entity_cleanup(struct media_entity *entity);
>  
>  int media_entity_create_link(struct media_entity *source, u16 source_pad,

How about putting this in front of the set? It has no dependencies to the
other patches, does it?

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
