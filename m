From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jul 2012 18:56:40 +0000
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <20120713174935.GN592@pengutronix.de>
References: <1342182734-321-1-git-send-email-y>
 <201207131624.27266.arnd@arndb.de> <20120713174935.GN592@pengutronix.de>
Message-ID: <201207131856.40599.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012, Uwe Kleine-K?nig wrote:
> > @@ -502,15 +502,15 @@ static const struct fsl_msi_feature vmpic_msi_feature = {
> >  static const struct of_device_id fsl_of_msi_ids[] = {
> >       {
> >               .compatible = "fsl,mpic-msi",
> > -             .data = (void *)&mpic_msi_feature,
> > +             .data = &mpic_msi_feature,
> This looks unrelated.
> 


Well, the cast to (void *) was used to cast away the const-ness of the
"static const struct fsl_msi_feature mpic_msi_feature", so that is no
longer needed after the last patch.

	Arnd.
