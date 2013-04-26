From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 26 Apr 2013 11:18:40 +0100
Subject: [RFC PATCH v3 02/17] Documentation: devicetree: arm: cpus/cpu
 nodes bindings updates
In-Reply-To: <CAL_JsqL2QOjTffogB6g7VK7oRUwDAmJpr=36uvFXjd+hpBL89A@mail.gmail.com>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqL2QOjTffogB6g7VK7oRUwDAmJpr=36uvFXjd+hpBL89A@mail.gmail.com>
Message-ID: <20130426101839.GA3093@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 03:51:10AM +0100, Rob Herring wrote:
> On Wed, Apr 24, 2013 at 12:28 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> >
> > Main changes:
> >     - adds 64-bit bindings
> >     - define usage of #address-cells
> >     - define 32/64 dts compatibility settings
> >     - defines behaviour on pre and post v7 uniprocessor systems
> >     - adds ARM 11MPcore specific reg property definition
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> 
> [...]
> 
> > +       - enable-method
> > +               Value type: <stringlist>
> > +               Usage and definition depend on ARM architecture version and
> > +               configuration:
> > +                       # On ARM v8 64-bit systems running the OS in AArch64,
> > +                         this property is required and must be "spin-table".
> 
> What about PSCI?

I should add it, at least for ARM v8.

> I don't think the ePAPR spin-table definition is sufficient for ARM.
> How do you define wake up by SGI or sev instruction.

I think Will described the wfe/sev mechanism in:

Documentation/arm64/booting.txt

and the ePAPR does the same in 5.5.2.2/5.5.2.3. Since this is a document
describing cpus/cpu nodes bindings I assume that description does not
belong here. Question is: do we need to specify an ARM implementation
specific enable-method to describe SGI/sev wake-up (ePAPR 5.5.3) ?

> > +                       # On ARM 32-bit systems or ARM v8 systems running
> > +                         the OS in AArch32 this property is prohibited.
> 
> Why?

Because if we define it optional with no possible set of values basically
it can be whatever string. I could define it optional with the same
allowed values as ARM v8 even if it is currently ignored, at least in Linux,
until PSCI implementations get merged.

Thanks,
Lorenzo
