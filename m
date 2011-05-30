From: olofj@google.com (Olof Johansson)
Date: Sun, 29 May 2011 20:11:34 -0700
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110528012427.GB5971@opensource.wolfsonmicro.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205721.21000.78599.stgit@riker>
	<20110528012427.GB5971@opensource.wolfsonmicro.com>
Message-ID: <BANLkTinKLcYmStvBEGDcN84BapJXe5Y5bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 6:24 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 27, 2011 at 01:57:26PM -0700, John Bonesio wrote:
>
>> ? ? ? harmony_audio: audio_card {
>> ? ? ? ? ? ? ? compatible = "nvidia,harmony-audio";
>> +
>> + ? ? ? ? ? ? gpios = <&codec 226 0>, /* spkr_en, gpio wm8903 #2 */
>> + ? ? ? ? ? ? ? ? ? ? <&gpio 178 0>, /* hp_det, gpio PW2 */
>> + ? ? ? ? ? ? ? ? ? ? <&gpio 184 0>, /* int_mic_en, gpio PX0 */
>> + ? ? ? ? ? ? ? ? ? ? <&gpio 185 0>; /* ext_mic_en, gpio PX1 */
>> +
>
> This is a step back from the usability of the existing platform data -
> the platform data uses a series of individually named GPIOs while this
> uses an array of GPIO numbers with magic indexes. ?The fact that you
> need comments explaining what the functions of the array elements are
> is a bit of a red flag here.

Agreed, I had similar concerns with the sdhci bindings where it used a
3-element array of gpios instead of the previous named ones. I was
told it's common practice to do it that way though? Seems like a step
backwards to me. :(


-Olof
