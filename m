From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 2 Jun 2017 18:23:56 +0100
Subject: [PATCH v2 1/3] perf: xgene: Parse PMU subnode from the match table
In-Reply-To: <CAFHUOYwYU4TTLWODX0=15uwDGusdydcX_s8G_Ji81N0c+Bkdqg@mail.gmail.com>
References: <1491238077-20666-1-git-send-email-hotran@apm.com>
 <1491238077-20666-2-git-send-email-hotran@apm.com>
 <20170602145934.GK28299@leverpostej>
 <CAFHUOYwYU4TTLWODX0=15uwDGusdydcX_s8G_Ji81N0c+Bkdqg@mail.gmail.com>
Message-ID: <20170602172355.GO28299@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 09:54:32AM -0700, Hoan Tran wrote:
> On Fri, Jun 2, 2017 at 7:59 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Apr 03, 2017 at 09:47:55AM -0700, Hoan Tran wrote:
> >> +static const struct acpi_device_id *xgene_pmu_acpi_match_type(
> >> +                                     const struct acpi_device_id *ids,
> >> +                                     struct acpi_device *adev)
> >> +{
> >> +     const struct acpi_device_id *match_id = NULL;
> >> +     const struct acpi_device_id *id;
> >> +
> >> +     for (id = ids; id->id[0] || id->cls; id++) {
> >> +             if (!acpi_match_device_ids(adev, id))
> >> +                     match_id = id;
> >> +             else if (match_id)
> >> +                     break;
> >> +     }
> >> +
> >> +     return match_id;
> >> +}
> >
> > I don't believe this look is necessary. AFAICT, acpi_match_device_ids()
> > already iterates over the id table it is given.
> 
> The acpi_match_device_ids() function just returns if a device ID is
> available on the given list. It does not return the first matching ID.
> That's the reason I created this function to find the first matching ID.

Ah, I see. Thanks for correcting me!

Can we use acpi_match_device(ids, &adev->dev), or is that the wrong dev?

Thanks,
Mark.
