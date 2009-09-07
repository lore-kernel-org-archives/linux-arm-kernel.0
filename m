From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Sep 2009 13:53:42 +0200
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <m2iqfvkqbl.fsf@arbois.toulouse.it.atosorigin.com>
References: <200908031031.00676.marek.vasut@gmail.com>
	<200909071050.11531.marek.vasut@gmail.com>
	<m2iqfvkqbl.fsf@arbois.toulouse.it.atosorigin.com>
Message-ID: <200909071353.43080.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 7. z??? 2009 12:21:50 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > How's it supposed to get BGR555 if the pxa-camera doesnt support that ?
> > Will the v4l2 layer convert it or something ?
>
> In pxa_camera.c, function pxa_camera_get_formats() :
> >         default:
> >                 /* Generic pass-through */
> >                 formats++;
> >                 if (xlate) {
> >                         xlate->host_fmt = icd->formats + idx;
> >                         xlate->cam_fmt = icd->formats + idx;
> >                         xlate->buswidth = icd->formats[idx].depth;
> >                         xlate++;
> >                         dev_dbg(ici->dev,
> >                                 "Providing format %s in pass-through
> > mode\n", icd->formats[idx].name);
> >                 }
> >         }
>
> "Pass-through" means that if a sensors provides a cc, ie. BGR555 for
> example, the bridge (pxa_camera) will "forward" to RAM the image in the
> very same cc (ie. BGR555). In that case, the bridge is a dummy "sensor to
> RAM" bus translator if you prefer.
>
> Marek, you should activate debug trace and watch for yourself. You can
> trust Guennadi, when he says it will work, well ... it will work.
>
> If it's out of technical curiousity, check the function above.  If you're
> even more curious, there was a thread in linux-media about "RFC: bus
> configuration setup for sub-devices", a very interesting one, especially
> considering the "pass-through" issue.

That one should work for RGB565X ? (the piece of code you posted ?) It's 
interesting it didnt work for me ... ok, I'll take it it works then, whatever. 
I'll test it again when I have time.
>
> Cheers.
>
> --
> Robert
