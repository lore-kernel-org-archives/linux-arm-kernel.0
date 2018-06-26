From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 26 Jun 2018 15:21:54 +0200
Subject: [PATCH 00/14] ARM: davinci: step towards removing
 at24_platform_data
In-Reply-To: <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
References: <20180625155025.12567-1-brgl@bgdev.pl>
 <20180625174024.GB17417@lunn.ch>
 <CAMRc=MdEn74G5SJAaGLAfNSS7Zy7wqH04aN5CMZ45UXqhu_58g@mail.gmail.com>
 <20180625180237.GC17417@lunn.ch>
 <CAMRc=MejDn=t6EPbKOfhMfRAb_O-5hxtWRyjAWH1mb5BUySrDA@mail.gmail.com>
 <20180626083823.GA28068@lunn.ch>
 <CAMRc=Mdvh+1enpD3qDoamhPfaBPin2v3amneQELApgoC0bS2FQ@mail.gmail.com>
Message-ID: <20180626132154.GA5064@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I see. I see it this way: the setup callback comes from the time when
> we didn't have nvmem and should go away. I will protest loud whenever
> someone will try to use it again and will work towards removing it as
> soon as possible.

The setup() callback could be moved into the nvmem framework, rather
than in the at24 driver. Make the call when the cells have been
connected to the backing store.

> I will give your problem a thought and will try to get back with some
> proposals - maybe we should, as you suggested, extend nvmem even
> further to allow to remove nvmem info entries etc.

That does not help me too much. I have the same problem with i2c and
MDIO. So i actually prefer to keep this the same as all others.

	Andrew
