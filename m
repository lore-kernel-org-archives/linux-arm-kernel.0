From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Tue, 24 Nov 2015 08:32:08 -0200
Subject: [PATCH 13/18] [media] media-entity.h: rename entity.type to
 entity.function
In-Reply-To: <7197567.LfPs5Bvqpi@avalon>
References: <cover.1441559233.git.mchehab@osg.samsung.com>
 <10e7edf1c85965d8ef8c6c5f527fd695a2660fc4.1441559233.git.mchehab@osg.samsung.com>
 <7197567.LfPs5Bvqpi@avalon>
Message-ID: <20151124083208.590bebbb@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Mon, 23 Nov 2015 19:51:41 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> Thank you for the patch.
> 
> On Sunday 06 September 2015 14:30:56 Mauro Carvalho Chehab wrote:
> > Entities should have one or more functions. Calling it as a
> > type proofed to not be correct, as an entity could eventually
> 
> s/proofed/proved/
> 
> > have more than one type.
> > 
> > So, rename the field as function.
> 
> s/as/to/
> 
> > Please notice that this patch doesn't extend support for
> > multiple function entities. Such change will happen when
> > we have real case drivers using it.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> 
> [snip]
> 
> > diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> > index 8bdc10dcc5e7..10f7d5f0eb66 100644
> > --- a/include/media/media-entity.h
> > +++ b/include/media/media-entity.h
> > @@ -152,7 +152,8 @@ struct media_entity_operations {
> >   *
> >   * @graph_obj:	Embedded structure containing the media object common data.
> >   * @name:	Entity name.
> > - * @type:	Entity type, as defined at uapi/media.h (MEDIA_ENT_T_*)
> > + * @function:	Entity main function, as defined at uapi/media.h
> > + *		(MEDIA_ENT_F_*)
> 
> I would squash this patch with "uapi/media.h: Rename entities types to 
> functions" as they essentially touch the same lines. 

They touch at the same lines, but the rationale is different. Keeping
it separate is, IMHO, better, as one logical change per patch is preferred.

> If you want to keep them 
> separate I would use MEDIA_ENT_T_* here and rename it to MEDIA_ENT_F_* in 
> "uapi/media.h: Rename entities types to functions".

IMHO, that would be confusing, as this patch would be incomplete, and
the other one would be renaming from MEDIA_ENT_T_* to MEDIA_ENT_F_*
due to a reason that it is on a different patch.

> 
> >   * @revision:	Entity revision - OBSOLETE - should be removed soon.
> >   * @flags:	Entity flags, as defined at uapi/media.h (MEDIA_ENT_FL_*)
> >   * @group_id:	Entity group ID - OBSOLETE - should be removed soon.
> 
> [snip]
> 
