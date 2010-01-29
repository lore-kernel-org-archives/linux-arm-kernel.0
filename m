From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 29 Jan 2010 10:08:04 +0900
Subject: [alsa-devel] [PATCHv2 05/10] ASoC: AC97: SMDK: Add wm9713 machine
	driver
In-Reply-To: <20100128120020.GA19270@sirena.org.uk>
References: <1264571959-15115-1-git-send-email-jassisinghbrar@gmail.com>
	<20100128120020.GA19270@sirena.org.uk>
Message-ID: <1b68c6791001281708ve324caaoa52581e3ebce09bd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 9:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jan 27, 2010 at 02:59:19PM +0900, jassisinghbrar at gmail.com wrote:
>
>> + ? ? Headphone Playback Switch - On
>> + ? ? $ amixer cset numid=4 1
>> +
>
> Actually, one thing that really needs fixing here - these instructions
> refer to the controls by number. ?This is extremely fragile in the face
> of any changes in the CODEC driver since the control numbering is worked
> out at runtime and any change in the set of controls exported by the
> device may change the result. ?It is much better to refer to the
> controls by name since the names are much less likely to change. ?This
> is also helpful for people using other UIs which don't display the
> control names.
I will submit a patch for it, though I used exact control names and their
values before every command.
