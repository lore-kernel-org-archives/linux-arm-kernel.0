From: yong.mao@mediatek.com (Yong Mao)
Date: Fri, 3 Mar 2017 11:49:55 +0800
Subject: [PATCH v4 1/3] mmc: dt-bindings: update Mediatek MMC bindings
In-Reply-To: <CAL_Jsq+eo-Fy8Wf2yZpE3Ufp4V_7Gn+w9fTyjZDP6V7tY-=gdw@mail.gmail.com>
References: <1484988923-1543-1-git-send-email-yong.mao@mediatek.com>
 <1484988923-1543-2-git-send-email-yong.mao@mediatek.com>
 <CAPDyKFqo7fMTp3YPJwgoa4u3iAie2U884VUfTnMQ_js8neMqTQ@mail.gmail.com>
 <1487930376.22858.14.camel@mhfsdcap03>
 <CAL_Jsq+eo-Fy8Wf2yZpE3Ufp4V_7Gn+w9fTyjZDP6V7tY-=gdw@mail.gmail.com>
Message-ID: <1488512995.21451.16.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-24 at 16:47 -0600, Rob Herring wrote:
> On Fri, Feb 24, 2017 at 3:59 AM, Yong Mao <yong.mao@mediatek.com> wrote:
> > Dear Rob,
> >
> > Could you please help to make comments for this patch?
> > Thanks.
> 
> I already did comment. It's still wrong as Ulf commented. So fix and
> send a new version. It has to go to the DT list if you want to be in
> my queue.
> 
> Rob

After reviewing the history, We guess your mentioned Ulf's comments is as below.
  
"> +- mtk-hs200-cmd-int-delay: HS200 command internal delay setting.
> + The value is an integer from 0 to 31

Please change to:

mediatek,hs200-cmd-delay

... and if there is a unit, like ns or us, please add that a suffix.

> +- mtk-hs400-cmd-int-delay: HS400 command internal delay setting
> + The value is an integer from 0 to 31

mediatek,hs400-cmd-delay and add unit if applicable.

> +- mtk-hs400-cmd-resp-sel: HS400 command response sample selection
> + The value is an integer from 0 to 1

mediatek,hs400-cmd-resp-sel

And make it a boolean value instead!"

==> We already fix this comment in v4. 
We use "mediatek,hs200-cmd-int-delay" to replace "mtk-hs200-cmd-int-delay", 
but not use "mediatek,hs200-cmd-delay". This is because "-int-" here means internal.
We should not drop it.

And this field does not have unit, it only have total 32 stages.
We also change the description in v4.

For comment about "mtk-hs400-cmd-resp-sel", we also make it a boolean value in v4.
And re-name it as "mediatek,hs400-cmd-resp-rising".

Please help to point out where we need to modify.
Thanks.
