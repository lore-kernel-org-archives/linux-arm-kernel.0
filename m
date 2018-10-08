From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 8 Oct 2018 15:29:05 +0530
Subject: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
In-Reply-To: <CADYwmhHdTuK-z4GcGCYypYo2dvvPj7udihPcMmTkHTSU2fOWWw@mail.gmail.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
 <CADYwmhHdTuK-z4GcGCYypYo2dvvPj7udihPcMmTkHTSU2fOWWw@mail.gmail.com>
Message-ID: <CAKTKpr7nq7jfXzHmTd-EX6b3MDefa6B5i--Zn=yUZV7MqS2ywA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranith,

On Sat, Jul 7, 2018 at 11:22 AM Pranith Kumar <pranith.foss@gmail.com> wrote:
>
> Hi Ganapatrao,
>
>
> On Wed, Jun 20, 2018 at 11:33 PM, Ganapatrao Kulkarni
> <ganapatrao.kulkarni@cavium.com> wrote:
>
> > +
> > +enum thunderx2_uncore_l3_events {
> > +       L3_EVENT_NONE,
> > +       L3_EVENT_NBU_CANCEL,
> > +       L3_EVENT_DIB_RETRY,
> > +       L3_EVENT_DOB_RETRY,
> > +       L3_EVENT_DIB_CREDIT_RETRY,
> > +       L3_EVENT_DOB_CREDIT_RETRY,
> > +       L3_EVENT_FORCE_RETRY,
> > +       L3_EVENT_IDX_CONFLICT_RETRY,
> > +       L3_EVENT_EVICT_CONFLICT_RETRY,
> > +       L3_EVENT_BANK_CONFLICT_RETRY,
> > +       L3_EVENT_FILL_ENTRY_RETRY,
> > +       L3_EVENT_EVICT_NOT_READY_RETRY,
> > +       L3_EVENT_L3_RETRY,
> > +       L3_EVENT_READ_REQ,
> > +       L3_EVENT_WRITE_BACK_REQ,
> > +       L3_EVENT_INVALIDATE_NWRITE_REQ,
> > +       L3_EVENT_INV_REQ,
> > +       L3_EVENT_SELF_REQ,
> > +       L3_EVENT_REQ,
> > +       L3_EVENT_EVICT_REQ,
> > +       L3_EVENT_INVALIDATE_NWRITE_HIT,
> > +       L3_EVENT_INVALIDATE_HIT,
> > +       L3_EVENT_SELF_HIT,
> > +       L3_EVENT_READ_HIT,
> > +       L3_EVENT_MAX,
> > +};
> > +
> > +enum thunderx2_uncore_dmc_events {
> > +       DMC_EVENT_NONE,
> > +       DMC_EVENT_COUNT_CYCLES,
> > +       DMC_EVENT_RES2,
> > +       DMC_EVENT_RES3,
> > +       DMC_EVENT_RES4,
> > +       DMC_EVENT_RES5,
> > +       DMC_EVENT_RES6,
> > +       DMC_EVENT_RES7,
> > +       DMC_EVENT_RES8,
> > +       DMC_EVENT_READ_64B_TXNS,
> > +       DMC_EVENT_READ_BELOW_64B_TXNS,
> > +       DMC_EVENT_WRITE_TXNS,
> > +       DMC_EVENT_TXN_CYCLES,
> > +       DMC_EVENT_DATA_TRANSFERS,
> > +       DMC_EVENT_CANCELLED_READ_TXNS,
> > +       DMC_EVENT_CONSUMED_READ_TXNS,
> > +       DMC_EVENT_MAX,
> > +};
>
> Can you please provide a link to where these counters are documented?
> It is not clear what each counter does especially for the L3C events.

I will add brief description of each event in Documentation.
>
> Also, what counter do you need to use to get L3 hit/miss ratio? I
> think this is the most useful counter related to L3.

L3C cache Hit Ratio = (L3_READ_HIT + L3_INV_N_WRITE_HIT +
L3_INVALIDATE_HIT) / (L3_READ_REQ + L3_INV_N_WRITE_REQ +
L3_INVALIDATE_REQ)

>
> Thanks,
> --
> Pranith

thanks
Ganapat
