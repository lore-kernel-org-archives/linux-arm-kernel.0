From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 12:09:12 -0500
Subject: [PATCH 1/3] Documentation: dtb: xgene: Add hwmon dts binding
 documentation
In-Reply-To: <CAFHUOYyYt8pE6sggezCR=TFcsimcjakbYmcWFtpLyQ3Et_gZaA@mail.gmail.com>
References: <1463415447-29903-1-git-send-email-hotran@apm.com>
 <1463415447-29903-2-git-send-email-hotran@apm.com>
 <20160523203044.GA17450@rob-hp-laptop>
 <CAFHUOYyYt8pE6sggezCR=TFcsimcjakbYmcWFtpLyQ3Et_gZaA@mail.gmail.com>
Message-ID: <20160525170912.GA24382@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 23, 2016 at 06:01:14PM -0700, Hoan Tran wrote:
> Hi Rob,
> 
> Thanks for your review !
> 
> On Mon, May 23, 2016 at 1:30 PM, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, May 16, 2016 at 09:17:25AM -0700, Hoan Tran wrote:
> > > This patch adds the APM X-Gene hwmon device tree node documentation.
> > >
> > > Signed-off-by: Hoan Tran <hotran@apm.com>
> > > ---
> > >  .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt          | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
> > > new file mode 100644
> > > index 0000000..49a482e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
> > > @@ -0,0 +1,14 @@
> > > +APM X-Gene hwmon driver
> > > +
> > > +Hwmon driver accesses sensors over the "SLIMpro" mailbox.
> >
> > DT bindings describe h/w, not driver data.
> How about this description: "APM X-Gene SOC sensors are accessed over
> the "SLIMpro" mailbox" ?
> > I'm not sure this belongs in
> > DT and perhaps the devices for the mailbox should be created by the
> > mailbox driver.
> I don't think the current mailbox supports it.

Then add it. The mailbox binding is really only needed when other h/w 
blocks use a mailbox. As this is purely a firmware interface then the 
mailbox driver can create any devices it needs. The devices don't have 
to be in DT to be created.

Rob
