From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 28 Oct 2015 22:41:35 -0500
Subject: [PATCH 1/2] mm: mmap: Add new /proc tunable for mmap_base ASLR.
In-Reply-To: <CAEP4de2GsEwn0eeO126GEtFb-FSJoU3fgOWTAr1yPFAmyXTi0Q@mail.gmail.com>
 (Dan Cashman's message of "Wed, 28 Oct 2015 17:39:49 -0700")
References: <1446067520-31806-1-git-send-email-dcashman@android.com>
 <871tcewoso.fsf@x220.int.ebiederm.org>
 <CABXk95DOSKv70p+=DQvHck5LCvRDc0WDORpoobSStWhrcrCiyg@mail.gmail.com>
 <CAEP4de2GsEwn0eeO126GEtFb-FSJoU3fgOWTAr1yPFAmyXTi0Q@mail.gmail.com>
Message-ID: <87oafiuys0.fsf@x220.int.ebiederm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan Cashman <dcashman@android.com> writes:

>> > This all would be much cleaner if the arm architecture code were just to
>> > register the sysctl itself.
>> >
>> > As it sits this looks like a patchset that does not meaninfully bisect,
>> > and would result in code that is hard to trace and understand.
>>
>> I believe the intent is to follow up with more architecture specific
>> patches to allow each architecture to define the number of bits to use
>
> Yes.  I included these patches together because they provide mutual
> context, but each has a different outcome and they could be taken
> separately.

They can not.  The first patch is incomplete by itself.

> The arm architecture-specific portion allows the changing
> of the number of bits used for mmap ASLR, useful even without the
> sysctl.  The sysctl patch (patch 1) provides another way of setting
> this value, and the hope is that this will be adopted across multiple
> architectures, with the arm changes (patch 2) providing an example.  I
> hope to follow this with changes to arm64 and x86, for example.

If you want to make the code generic.  Please maximize the sharing.
That is please define the variables in a generic location, as well
as the Kconfig variables (if possible).

As it is you have an architecture specific piece of code that can not be
reused without duplicating code, and that is just begging for problems.

Eric
