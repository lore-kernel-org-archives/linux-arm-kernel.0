From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Nov 2016 19:10:22 +0000
Subject: Summary of LPC guest MSI discussion in Santa Fe
In-Reply-To: <5822214F.2070500@redhat.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home>
 <20161108024559.GA20591@arm.com>
 <dae12190-1eb6-20a9-5740-9e5be8bb65fc@redhat.com>
 <20161108175457.GK20591@arm.com> <5822214F.2070500@redhat.com>
Message-ID: <20161108191022.GA17771@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 02:02:39PM -0500, Don Dutile wrote:
> On 11/08/2016 12:54 PM, Will Deacon wrote:
> >A first step would be making all this opt-in, and only supporting GICv3
> >ITS for now.
> You're trying to support a config that is < GICv3 and no ITS ? ...
> That would be the equiv. of x86 pre-intr-remap, and that's why allow_unsafe_interrupts
> hook was created ... to enable devel/kick-the-tires.

Yup, that's exactly what I was envisaging. For systems that can't do
passthrough safely, we'll always have to throw a devel switch.

Will
