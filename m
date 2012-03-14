From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 13 Mar 2012 21:42:05 -0700
Subject: [PATCH v4] Input: keyboard - add device tree bindings for simple
 key matrixes
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
References: <1325484557-27695-1-git-send-email-olof@lixom.net>
 <1325626648-9425-1-git-send-email-olof@lixom.net>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F11FF@HQMAIL01.nvidia.com>
Message-ID: <20120314044205.GA3964@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2012 at 02:37:44PM -0800, Stephen Warren wrote:
> Olof Johansson wrote at Tuesday, January 03, 2012 2:37 PM:
> > This adds a simple device tree binding for simple key matrix data and
> > a helper to fill in the platform data.
> > 
> > The implementation is in a shared file outside if drivers/input/keyboard
> > since some drivers in drivers/input/misc might be making use of it
> > as well.
> > 
> > Changes since v3:
> >  * Dropped compatible field in matrix-keymap.txt
> >  * Dropped linux,fn-key
> >  * Dropped linux,fn-keymap optional property but included guideline on
> >    naming convention
> >  * Now passing property name in to the helper function (or will assume
> >    "linux,keymap" if passed NULL)
> 
> > diff --git a/drivers/input/of_keymap.c b/drivers/input/of_keymap.c
> 
> > +struct matrix_keymap_data *
> > +matrix_keyboard_of_fill_keymap(struct device_node *np, char *propname)
> > +{
> ...
> > +	kd = kmalloc(sizeof(*kd), GFP_KERNEL);
> > +	if (!kd)
> > +		return NULL;
> 
> Should that use kzalloc in case struct matrix_keymap_data grows some
> new fields that people will assume are set to zero since the struct
> would usually be in .data? Still, people should probably grep the code
> when making such changes...
> 
> Otherwise,
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 

Applied, thanks everyone.

-- 
Dmitry
