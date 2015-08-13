From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Thu, 13 Aug 2015 09:58:16 +0200
Subject: [PATCH RFC v3 10/16] media: rename link source/sink to
 pad0_source/pad1_sink
In-Reply-To: <30472f0a7f52ee834978c70cbecc5c035ce20f71.1439410053.git.mchehab@osg.samsung.com>
References: <cover.1439410053.git.mchehab@osg.samsung.com>
 <30472f0a7f52ee834978c70cbecc5c035ce20f71.1439410053.git.mchehab@osg.samsung.com>
Message-ID: <55CC4E18.7080605@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/15 22:14, Mauro Carvalho Chehab wrote:
> Change the internal namespace for links between two pads to
> have the "pad" there.
> 
> We're also numbering it, as a common constructor is to do
> things like:
> 
>  	if (link->port1.type != MEDIA_GRAPH_PAD)
>  		continue;
>  	if (link->pad1_sink->entity == entity)
> 		/* do something */
> 
> by preserving the number, we keep consistency between
> port1 and pad1_sink, and port0 and pad0_source.

I would really leave this patch out. As long as sink and source are consistently
used for pads (and they are), then I see no benefit at all to this change.

Another reason why I don't like this is that pad0_ and pad1_ are actually
confusing since they suggested to me when I first read it that pad0_ referred to
the pad with index 0 and pad1_ referred to the pad with index 1.

That's obviously not the case, but it does mean that the prefix doesn't really
make things clearer.

I would just stick with source and sink.

Regards,

	Hans
