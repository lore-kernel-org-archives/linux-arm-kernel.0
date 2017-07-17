From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jul 2017 23:23:11 +0200
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <3a927e60-332a-f01d-f1af-98649e9f51b5@xs4all.nl>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
 <f57e08d9-0984-b67c-c64b-c7e0542d0361@xs4all.nl>
 <CAK8P3a1zBW_QuPtRFNwuVyE_ziySoV9_ebz4sD7Bya3eRoo8SA@mail.gmail.com>
 <3a927e60-332a-f01d-f1af-98649e9f51b5@xs4all.nl>
Message-ID: <CAK8P3a3rc-7mXsPosXG7jWBDf9D31816eRpTP266cC94B5jfWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 4:35 PM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 17/07/17 16:26, Arnd Bergmann wrote:

>> Let me try again without ccache for now and see what warnings remain.
>> We can find a solution for those first, and then decide how to deal with
>> ccache.
>
> Sounds good.
>
> I'm OK with applying this if there is no other way to prevent these warnings.

Small update: I noticed that having ccache being the default compiler
even with CCACHE_DISABLE=1 causes a lot of these warnings. Completely
taking ccache out of the picture however seems to have eliminated the
warnings about v4l2_subdev_call() and other silly warnings, but not
the interesting ones in the -Wint-in-bool-context category.

       Arnd
