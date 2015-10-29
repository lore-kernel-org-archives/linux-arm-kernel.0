From: dcashman@android.com (Dan Cashman)
Date: Wed, 28 Oct 2015 17:39:49 -0700
Subject: [PATCH 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <CABXk95DOSKv70p+=DQvHck5LCvRDc0WDORpoobSStWhrcrCiyg@mail.gmail.com>
References: <1446067520-31806-1-git-send-email-dcashman@android.com>
 <871tcewoso.fsf@x220.int.ebiederm.org>
 <CABXk95DOSKv70p+=DQvHck5LCvRDc0WDORpoobSStWhrcrCiyg@mail.gmail.com>
Message-ID: <CAEP4de2GsEwn0eeO126GEtFb-FSJoU3fgOWTAr1yPFAmyXTi0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This all would be much cleaner if the arm architecture code were just to
> > register the sysctl itself.
> >
> > As it sits this looks like a patchset that does not meaninfully bisect,
> > and would result in code that is hard to trace and understand.
>
> I believe the intent is to follow up with more architecture specific
> patches to allow each architecture to define the number of bits to use

Yes.  I included these patches together because they provide mutual
context, but each has a different outcome and they could be taken
separately.  The arm architecture-specific portion allows the changing
of the number of bits used for mmap ASLR, useful even without the
sysctl.  The sysctl patch (patch 1) provides another way of setting
this value, and the hope is that this will be adopted across multiple
architectures, with the arm changes (patch 2) providing an example.  I
hope to follow this with changes to arm64 and x86, for example.

On Wed, Oct 28, 2015 at 5:01 PM, Jeffrey Vander Stoep <jeffv@google.com> wrote:
> plain text this time...
>
>> This all would be much cleaner if the arm architecture code were just to
>> register the sysctl itself.
>>
>> As it sits this looks like a patchset that does not meaninfully bisect,
>> and would result in code that is hard to trace and understand.
>
> I believe the intent is to follow up with more architecture specific
> patches to allow each architecture to define the number of bits to use
> (min, max, and default) since these values are architecture dependent.
> Arm64 patch should be forthcoming, and others after that. With that in
> mind, would you still prefer to have the sysctl code in the
> arm-specific patch?
