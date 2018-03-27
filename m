From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 27 Mar 2018 16:48:01 +0800
Subject: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
In-Reply-To: <1522140259.1110.43.camel@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
 <20180323095529.5nptn5achjt3esog@flea>
 <1522137643.1110.4.camel@bootlin.com> <20180327081731.he3lhnvqffuimsi5@flea>
 <1522140259.1110.43.camel@bootlin.com>
Message-ID: <CAGb2v67bykhv6oTO0dQTyUOcB0CZZUPHg06F8K0oN5C_PH3E7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 4:44 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Hi,
>
> On Tue, 2018-03-27 at 10:17 +0200, Maxime Ripard wrote:
>> On Tue, Mar 27, 2018 at 10:00:43AM +0200, Paul Kocialkowski wrote:
>> > Hi,
>> >
>> > On Fri, 2018-03-23 at 10:55 +0100, Maxime Ripard wrote:
>> > > On Wed, Mar 21, 2018 at 04:28:56PM +0100, Paul Kocialkowski wrote:
>> > > > The YUV channel was only disabled in
>> > > > sun4i_backend_update_layer_formats,
>> > > > which is not called when the frontend is selected.
>> > > >
>> > > > Thus, creating a layer with a YUV format handled by the backend
>> > > > and
>> > > > then
>> > > > switching to a format that requires the frontend would keep the
>> > > > YUV
>> > > > channel enabled for the layer.
>> > > >
>> > > > This explicitly disables the YUV channel for the layer when
>> > > > using
>> > > > the
>> > > > frontend as well. It also sets the relevant interlace bit, which
>> > > > was
>> > > > missing in the frontend path as well.
>> > >
>> > > This should be part of a separate patch. Usually, if you write "it
>> > > also does..." at the end of your commit log, it's a pretty good
>> > > indication that it should be another patch :)
>> >
>> > I must say, I figured that this part was missing in the frontend
>> > path by
>> > chance and couldn't really test the feature, so I'm also tempted to
>> > drop
>> > it altogether. What do you think?
>>
>> If you haven't been able to test it, then yeah, don't submit it.
>
> Alright, noted.
>
>> > Also, is interlacing actually used on any of the video outputs we
>> > support? Perhaps RGB?
>>
>> Composite would be a better guess :)
>
> Oh and I was wondering what CVBS was about. Now I know!
> It seems that we don't support it for now apparently, anyway.

You could also try adding interlaced modes to HDMI.

ChenYu
