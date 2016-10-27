From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 27 Oct 2016 09:20:14 +0800
Subject: [PATCH 02/12] ASoC: dapm: Implement stereo mixer control support
In-Reply-To: <20161026165753.GC25322@sirena.org.uk>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-3-wens@csie.org>
 <20161026165753.GC25322@sirena.org.uk>
Message-ID: <CAGb2v673TH0dw15wL6W6-i7tqu245epu22MxpEkjQuNHTBhnJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 12:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Oct 03, 2016 at 07:07:54PM +0800, Chen-Yu Tsai wrote:
>
>> While DAPM is mono or single channel, its controls can be shared between
>> widgets, such as sharing one stereo mixer control between the left and
>> right channel widgets.
>
>> This patch introduces support for such shared mixer controls.
>
> Based on this changelog I'm really not sure what the intended semantic
> of this change is which makes it difficult to review.  What are you
> expecting these controls to look like and how are you expecting them to
> work?
>
>> -static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
>> +static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i,
>> +                                    int nth_path)
>
> It looks like the goal is to attach more than one path to a single
> control somehow?

Correct. I'll try to expand the commit log and add an example diagram.

ChenYu
