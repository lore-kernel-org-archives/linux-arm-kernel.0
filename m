From: riel@redhat.com (Rik van Riel)
Date: Mon, 12 Jan 2015 22:33:12 -0500
Subject: Linux 3.19-rc3
In-Reply-To: <alpine.DEB.2.02.1501091849250.3078@nftneq.ynat.uz>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <54AE7D53.2020305@redhat.com>
 <20150108134520.GC14200@e104818-lin.cambridge.arm.com>
 <54AEBE84.6090307@redhat.com>
 <20150108173408.GF17290@e104818-lin.cambridge.arm.com>
 <54AED10C.7090305@redhat.com>
 <CA+55aFwpwkjRnTzBe2K0y+2DOH1F=5SpJkYe=P5z8ps5_1PQHQ@mail.gmail.com>
 <20150109232707.GA6325@e104818-lin.cambridge.arm.com>
 <20150110003540.GA32037@node.dhcp.inet.fi>
 <CA+55aFz74hjhCcdz5J4r-xK4KW7oqNDA3i=jXHW0prGMMwgMvw@mail.gmail.com>
 <alpine.DEB.2.02.1501091849250.3078@nftneq.ynat.uz>
Message-ID: <54B491F8.1070909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/2015 09:51 PM, David Lang wrote:
> On Fri, 9 Jan 2015, Linus Torvalds wrote:
> 
>> Big pages are a bad bad bad idea. They work fine for databases,
>> and that's pretty much just about it. I'm sure there are some
>> other loads, but they are few and far between.
> 
> what about a dedicated virtualization host (where your workload is
> a handful of virtual machines), would the file cache issue still
> be overwelming, even though it's the virtual machines accessing
> things?

You would still have page cache inside the guest.

Using large pages in the host, and small pages in the guest
would not give you the TLB benefits, and that is assuming
that different page sizes in host and guest even work...

Using large pages in the guests gets you back to the wasted
memory, except you are now wasting memory in a situation where
you have less memory available in each guest. Density is a real
consideration for virtualization.

- -- 
All rights reversed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUtJH4AAoJEM553pKExN6Dd3QH/ivcIo2n06Czg14/gL61MSHM
uZPOuMGQt51DYtF3s3mtDHqWyZq9hafz+2hoSJDwGIvVE6hJKVJ5rvb/OcN7AEKe
PWfru+bOvID0d4YOy38ax2tZwdItlL/sj1AbTbPXjnkLWm0yP3dYVM40dj47JvPy
+aE3iHB+wPZ+xxUmQ5KIlpRydUS1fl+tdmsiyi41fSFu8X19YDtDSrPylLk3to/w
6RGbHWLxJQZXJk+pkVWuSELmzWRrCaNaE7XBlvP9VS4U8bRg8WYJJXax1FBKLGBO
ygVt2OmqLi9dneN8ePNRUW8x2Y6OqjobDgCkOzTxJB8NrtRDJpSqWCI4W5xReBM=
=WhPN
-----END PGP SIGNATURE-----
